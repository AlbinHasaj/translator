class GlossariesController < ApplicationController
  before_action :set_glossary, only: :show

  def index
    glossaries = Glossary.all.as_json(
      only: %i[id source_language_code target_language_code],
      include: { terms: { only: %i[source_term target_term] } }
    )

    render json: glossaries
  end

  def show
    render json: @glossary.as_json(
      only: %i[id source_language_code target_language_code], include: { terms: { only: %i[source_term target_term] } }
    )
  end

  def create
    glossary = Glossary.new(glossary_params)

    if glossary.save
      render json: glossary.as_json(only: %i[id source_language_code target_language_code])
    else
      render json: glossary.errors, status: :unprocessable_entity
    end
  end

  private

  def set_glossary
    @glossary ||= Glossary.find(params[:id])
  end

  def glossary_params
    @glossary_params ||= params.permit(:source_language_code, :target_language_code)
  end
end
