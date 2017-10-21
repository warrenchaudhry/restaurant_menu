class MenusController < ApplicationController
  before_action :set_menu, only: [:show, :edit, :update, :destroy]
  before_action :set_default_params, only: [:index, :export]

  # GET /menus
  # GET /menus.json
  def index
    menus = Menu.where.not(event: nil, venue: nil)
    if params[:keyword].present?
      menus = menus.search(params[:keyword])
    elsif params[:venue].present?
      menus = menus.where(venue: params[:venue])
    elsif params[:event].present?
      menus = menus.where(event: params[:event])
    elsif params[:start_date].present? && params[:end_date].present?
      menus = menus.where('data BETWEEN ? AND ?', params[:start_date], params[:end_date])
    end
    @menus = menus.order("#{params[:sort]} #{params[:direction]}").page(params[:page]).per(params[:per_page])
  end

  # GET /menus/1
  # GET /menus/1.json
  def show
  end

  # GET /menus/new
  def new
    @menu = Menu.new
  end

  # GET /menus/1/edit
  def edit
  end

  # POST /menus
  # POST /menus.json
  def create
    @menu = Menu.new(menu_params)

    respond_to do |format|
      if @menu.save
        format.html { redirect_to @menu, notice: 'Menu was successfully created.' }
        format.json { render :show, status: :created, location: @menu }
      else
        format.html { render :new }
        format.json { render json: @menu.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /menus/1
  # PATCH/PUT /menus/1.json
  def update
    respond_to do |format|
      if @menu.update(menu_params)
        format.html { redirect_to @menu, notice: 'Menu was successfully updated.' }
        format.json { render :show, status: :ok, location: @menu }
      else
        format.html { render :edit }
        format.json { render json: @menu.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /menus/1
  # DELETE /menus/1.json
  def destroy
    @menu.destroy
    respond_to do |format|
      format.html { redirect_to menus_url, notice: 'Menu was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def import
    if !params.has_key?(:csv_file)
      flash[:error] = 'Please upload your migration CSV!'
      redirect_to menus_path
    else
      MenuImporter.new(file: params[:csv_file].path).import
      redirect_to menus_path, notice: "Import successful"
    end
  end

  def export
    params[:sort] ||= 'place'
    action_params = params.permit(:utf8, :commit, :page, :per_page, :sort, :direction, :place, :start_date, :end_date)
    menus = Menu.where.not(event: nil, venue: nil)
    if action_params[:place].present?
      menus = menus.where('LOWER(TRIM(place)) LIKE ?', "%#{action_params[:place].strip.downcase}%")
    end
    if action_params[:start_date].present? && action_params[:end_date].present?
      menus = menus.where('date BETWEEN ? AND ?', action_params[:start_date], action_params[:end_date])
    end
    respond_to do |format|
      format.html do
        @menus = menus.order("#{params[:sort]} #{params[:direction]}").page(params[:page]).per(params[:per_page])
      end
      format.json do
        send_data menus.to_json, filename: 'menus.json', type: 'application/json'
      end
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_menu
      @menu = Menu.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def menu_params
      params.require(:menu).permit(:name, :sponsor, :event, :venue, :place, :physical_description, :occasion, :notes, :call_number, :keywords, :language, :date, :location, :location_type, :currency, :currency_symbol, :status, :page_count, :dish_count)
    end

    def set_default_params
      params[:page] ||= 1
      params[:per_page] ||= 50
      params[:sort] ||= 'sponsor'
      params[:direction] ||= 'ASC'
    end
end
