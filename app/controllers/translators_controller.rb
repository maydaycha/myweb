class TranslatorsController < ApplicationController
  def index
    @translators = Translator.all()
  end

  def show
    @translator = Translator.find(params[:id])
  end

  def edit
    @translator = Translator.find(params[:id])
  end

  def new
    @translator = Translator.new
  end

  def create
    @translator = Translator.new(params.permit![:translator])
    @translator.save
    redirect_to translators_url
  end

  def update
    @translator = Translator.find(params[:id])
    @translator.update(params.permit![:translator])
    redirect_to translator_path(@translator)
  end

  def destroy
    @translator = Translator.find(params[:id])
    @translator.destroy
    redirect_to translators_path
  end
end
