require 'rails_helper'

RSpec.describe PoposController, type: :controller do
  describe "index" do
    it "assigns all POPOS to @popos" do
      get :index
      p :popos
      expect(assigns :popos).to eq(@popos = Popo.order(:id).page(1))
    end
  end
end
