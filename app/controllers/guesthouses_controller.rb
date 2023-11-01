class GuesthousesController < ApplicationController
  def new
    @guesthouse = Guesthouse.new
  end
end
