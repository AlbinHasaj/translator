require 'rails_helper'

RSpec.describe TermsController, type: :request do
  describe 'POST /glossaries' do
    context 'Glossary does not exist' do
      it 'Returns 404' do
        post '/glossaries/5/terms'

        expect(response).to have_http_status(404)
      end
    end

    context 'Glossary exists' do
      context 'With invalid params' do
        it 'Returns 422' do
          glossary = create(:glossary)

          post "/glossaries/#{glossary.id}/terms"

          expect(response).to have_http_status(422)
        end
      end

      context 'With valid params' do
        it 'Returns 200' do
          glossary = create(:glossary)
          term = build(:term)

          post "/glossaries/#{glossary.id}/terms", params: term.attributes

          expect(response).to have_http_status(200)
        end
      end
    end
  end
end
