require 'rails_helper'

RSpec.describe GlossariesController, type: :request do
  describe 'GET /glossaries' do
    it 'Returns all glossaries with their terms' do
      create(:glossary)
      other_glossary = create(:glossary, source_language_code: Language.all_codes.last)

      create(:term, glossary_id: other_glossary.id)

      get '/glossaries'

      expect(response).to have_http_status(200)
      expect(JSON.parse(body).first['terms']).to be_blank
      expect(JSON.parse(body).last['terms']).to_not be_blank
    end
  end

  describe 'GET /glossaries/:id' do
    context 'Glossary with that ID exists' do
      it 'Returns that specific glossary' do
        glossary = create(:glossary)

        get "/glossaries/#{glossary.id}"

        expect(response).to have_http_status(200)
        expect(JSON.parse(body)['id']).to eq(glossary.id)
      end
    end

    context 'Glossary with that ID does not exist' do
      it 'Returns 404' do
        get '/glossaries/5555'

        expect(response).to have_http_status(404)
      end
    end
  end

  context 'POST /glossaries' do
    context 'With invalid params' do
      it 'Returns 422' do
        post '/glossaries'

        expect(response).to have_http_status(422)
      end
    end

    context 'With valid params' do
      it 'returns 200' do
        glossary = build(:glossary)

        post '/glossaries', params: glossary.attributes

        expect(response).to have_http_status(200)
      end
    end
  end
end
