class Front::FaqsController < ApplicationController

  before_action :find_faq, only: [:show]

  def show
    respond_to do |format|
      format.html
      format.json {
        render json: @faq, status: 200
      }
    end
  end

  def index
    @faqs = Faq.all

    respond_to do |format|
      format.html
      format.json {
        render json: @faqs, status: 200
      }
    end
  end

  private

  def find_faq
    @faq = Faq.find(params[:id])
  end
end
