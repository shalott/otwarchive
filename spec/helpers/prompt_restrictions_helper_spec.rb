require 'spec_helper'

describe PromptRestrictionsHelper do

  describe "#get_prompt_restriction" do
    it "returns the right prompt restriction" do
      @gift_exchange = FactoryGirl.create(:gift_exchange)
      assign(:collection, FactoryGirl.create(:collection, :challenge => @gift_exchange))
      expect(helper.get_prompt_restriction).to equal(@gift_exchange.request_restriction)
      expect(helper.get_prompt_restriction(for_offer=true)).to equal(@gift_exchange.offer_restriction)
    end
  end

end
