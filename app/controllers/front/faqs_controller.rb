class Front::FaqsController < ApplicationController

  before_action :find_faq, only: [:show]

  def show

  end

  def index

  end

  private

  def find_faq
    @faq = Faq.find(params[:id])
  end
end
