class TranslationsController < ApplicationController
  before_action :set_glossary, only: :create
  before_action :set_translation, only: :show

  def show
    render json: {
      id: @translation.id,
      source_text: @translation.source_text,
      glossary_id: @translation.glossary_id,
      matching_terms: @translation.matching_terms
    }
  end

  def create
    translation = (@glossary.present? ? @glossary.translations : Translation).new(translation_params)

    if translation.save
      render json: translation
    else
      render json: translation.errors, status: :unprocessable_entity
    end
  end

  private

  def set_translation
    @translation ||= Translation.find(params[:id])
  end

  def set_glossary
    @glossary ||= Glossary.find_by_id(params[:glossary_id])
  end

  def translation_params
    params.permit(:source_language_code, :target_language_code, :source_text)
  end
end
