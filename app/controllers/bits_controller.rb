class BitsController < ApplicationController

  before_action :get_bit_from_id, only: ['edit', 'update', 'delete', 'destroy']

  def index
    @bits = Bit.by_recent
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def delete
  end

  def destroy
  end

  private

    def get_bit_from_id
      @bit = Bit.find(params[:id])
    end

end
