class NurseriesController < ApplicationController
  def show
    @nursery = Nursery.find(params[:id])
  end

  def new
  end
end
