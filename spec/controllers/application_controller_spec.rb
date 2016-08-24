require 'rails_helper'

describe ApplicationController do
  describe "url_for" do
    subject{ controller.url_for(params) }
    let(:params){ {controller: "welcome"} }

    context "with institution_param" do
      let(:institution_param){ "NS" }
      before { allow(controller).to receive(:institution_param).and_return institution_param }

      it { is_expected.to eq "http://test.host/?institution=NS" }
    end

    context "with institute_param" do
      let(:institute_param){ "NYUAD" }
      before { allow(controller).to receive(:institute_param).and_return institute_param }

      it { is_expected.to eq "http://test.host/?institute=NYUAD" }
    end
  end
end
