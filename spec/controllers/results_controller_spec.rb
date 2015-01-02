describe ResultsController do

  describe "#filter_params" do
    it "removes non-model params" do
      @params = ActionController::Parameters.new(result: {id: 1, foo: 'bar'})
    end

    it "removes empty param values" do
      @params = ActionController::Parameters.new(result: {id: 1, foo: ''})
    end

    after do
      expect(controller.filter_params(@params)).to eq({id: 1})
    end
  end
end