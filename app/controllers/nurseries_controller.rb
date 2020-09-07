class NurseriesController < ApplicationController
  def show
    @nursery = Nursery.find(params[:id])
  end

  def new
    @nursery = Nursery.new
  end
end
