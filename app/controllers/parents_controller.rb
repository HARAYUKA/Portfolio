class ParentsController < ApplicationController
  def show
    @parent = Parent.find(params[:id])
  end

  def new
  end
end
