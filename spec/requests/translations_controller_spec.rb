require 'rails_helper'

RSpec.describe TranslationsController, type: :request do
  describe 'GET /translations/:id' do
    context 'Translation exist' do
      it 'Returns 200' do
        translation = create(:translation)

        get "/translations/#{translation.id}"

        expect(response).to have_http_status(200)
      end

      it 'Returns the matching terms' do
        translation = create(:translation, source_text: 'test not yes')

        create(:term, glossary: translation.glossary, source_term: 'test', target_term: 'test')
        create(:term, glossary: translation.glossary, source_term: 'not', target_term: 'not')

        get "/translations/#{translation.id}"
        matching_terms = JSON.parse(body)['matching_terms']

        expect(matching_terms.first['glossary_term']).to eq('test')
        expect(matching_terms.first['highlighted_source_text']).to eq('<HIGHLIGHT>test</HIGHLIGHT> not yes')

        expect(matching_terms.last['glossary_term']).to eq('not')
        expect(matching_terms.last['highlighted_source_text']).to eq('test <HIGHLIGHT>not</HIGHLIGHT> yes')
      end
    end

    context 'Translation does not exist' do
      it 'Returns 404' do
        get '/translations/515'

        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'POST /translations' do
    context 'With valid params' do
      it 'Returns 200' do
        translation = build(:translation)

        post '/translations', params: translation.attributes

        expect(response).to have_http_status(200)
      end
    end

    context 'With invalid params' do
      it 'Returns 422' do
        post '/translations'

        expect(response).to have_http_status(422)
      end
    end
  end
end
