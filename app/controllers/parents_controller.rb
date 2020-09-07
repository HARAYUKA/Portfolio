class ParentsController < ApplicationController
  def show
    @parent = Parent.find(params[:id])
  end

  def new
    @parent = Parent.new
  end
end
