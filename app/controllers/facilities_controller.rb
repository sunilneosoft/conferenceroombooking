class FacilitiesController < ApplicationController
  before_action :set_facility, only: [:show, :edit, :update, :destroy]

  def index
    params[:page] = 1 if params[:page].blank?
    @facilities = Facility.page(params[:page]).per(20)
  end

  def show
  end

  def new
    @facility = Facility.new
  end

  def edit
  end

  def create
    @facility = Facility.create(facility_params)
    return render :new  if @facility.errors.present?
    redirect_to facilities_path, notice: 'room was successfully created.'
  end

  def update
    return render :edit if not @facility.update(facility_params)
    redirect_to facilities_path, notice: 'room was successfully updated.'
  end

  def destroy
    @facility.destroy
    redirect_to facilities_path, notice: 'room was successfully destroyed.'
  end

  def search
    @search_result = Facility.search(params)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_facility
      @facility = Facility.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def facility_params
      params.require(:facility).permit(:title, :desctription)
    end
end
