# frozen_string_literal: true

describe "Api::V1::Me::Records" do
  let(:access_token) { create(:oauth_access_token) }
  let(:work) { create(:work, :with_current_season) }
  let!(:status) do
    create(:status, kind: "watching", work: work, user: access_token.owner)
  end

  describe "GET /v1/me/works" do
    before do
      data = {
        access_token: access_token.token
      }
      get api("/v1/me/works", data)
    end

    it "responses 200" do
      expect(response.status).to eq(200)
    end

    it "gets works which user has updated their statuses" do
      expected_hash = {
        "id" => work.id,
        "title" => work.title,
        "title_kana" => work.title_kana,
        "media" => "tv",
        "media_text" => "TV",
        "season_name" => "2016-autumn",
        "season_name_text" => "2016年秋",
        "released_on" => "2012-04-05",
        "released_on_about" => "2012年",
        "official_site_url" => "http://example.com",
        "wikipedia_url" => "http://wikipedia.org",
        "twitter_username" => "precure_official",
        "twitter_hashtag" => "precure",
        "episodes_count" => 0,
        "watchers_count" => 1
      }
      expect(json["works"][0].stringify_keys).to include(expected_hash)
      expect(json["total_count"]).to eq(1)
      expect(json["next_page"]).to eq(nil)
      expect(json["prev_page"]).to eq(nil)
    end
  end
end
