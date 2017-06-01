require 'rails_helper'

describe 'Recipes API' do
  context "displaying only recipes" do
    it "lists all recipes" do
      FactoryGirl.create_list(:recipe, 9)

      get '/v1/recipes'

      json = JSON.parse(response.body)
      
      # Ожидаем 200 ответ - успех
      expect(response).to be_success

      # Ожидаем нужно кол-во записей
      expect(json['data'].length).to eq(9)
    end

    it "shows a recipe" do
      recipe = FactoryGirl.create(:recipe)

      get "/v1/recipes/#{recipe.id}"

      json = JSON.parse(response.body)

      expect(response).to be_success
      expect(json['data']['id'].to_i).to eq(recipe.id)
    end
  end

  context "displaying only recipe categories" do
    it "lists all recipe categories" do
      FactoryGirl.create_list(:recipe_category, 4)

      get '/v1/recipe_categories'

      json = JSON.parse(response.body)

      expect(response).to be_success
      expect(json['data'].length).to eq(4)
    end

    it 'shows a recipe category' do
      recipe_category = FactoryGirl.create(:recipe_category)

      get "/v1/recipe_categories/#{recipe_category.id}"

      json = JSON.parse(response.body)

      expect(response).to be_success
      expect(json['data']['id'].to_i).to eq(recipe_category.id)
    end
  end

  context "displaying recipes from current recipe category" do
    before(:each) {
      @category = FactoryGirl.create(:recipe_category)
    }

    it "returns 400 for non-existing recipe category listing all recipes" do
      get "/v1/recipe_categories/222/recipes"

      expect(response.status).to eq(400)
    end

    it "returns 400 for non-existing recipe category listing specific existing recipe" do
      recipe = FactoryGirl.create(:recipe)
      get "/v1/recipe_categories/222/recipes/#{recipe.id}"

      expect(response.status).to eq(400)
    end

    it "lists all recipes" do
      FactoryGirl.create_list(:recipe, 4, recipe_category_id: @category.id)

      get "/v1/recipe_categories/#{@category.id}/recipes"

      json = JSON.parse(response.body)

      expect(response).to be_success
      expect(json['data'].length.to_i).to eq(4)
    end

    it "lists only recipes from specific category" do
      FactoryGirl.create_list(:recipe, 6)
      FactoryGirl.create_list(:recipe, 4, recipe_category_id: @category.id)

      get "/v1/recipe_categories/#{@category.id}/recipes"

      json = JSON.parse(response.body)

      expect(json['data'].length.to_i).not_to eq(10)

      json['data'].each do |item|
        expect(item['attributes']['category']['id'].to_i).to eq(@category.id)
      end
    end

    it "shows a specific recipe" do
      recipe = FactoryGirl.create(:recipe, recipe_category_id: @category.id)

      get "/v1/recipe_categories/#{@category.id}/recipes/#{recipe.id}"
      json = JSON.parse(response.body)

      expect(response).to be_success
      expect(json['data']['id'].to_i).to eq(recipe.id)
    end

    it "returns 400 for non-existing recipe" do
      get "/v1/recipe_categories/#{@category.id}/recipes/155"

      expect(response.status).to eq(400)
    end
  end
  
end