class TermsController < ApplicationController
  before_action :set_glossary

  def create
    term = @glossary.terms.new(glossary_params)

    if term.save
      render json: term.as_json(only: %i[id source_term target_term glossary_id])
    else
      render json: term.errors, status: :unprocessable_entity
    end
  end

  private

  def set_glossary
    @glossary ||= Glossary.find(params[:id])
  end

  def glossary_params
    @glossary_params ||= params.permit(:source_term, :target_term)
  end
end
