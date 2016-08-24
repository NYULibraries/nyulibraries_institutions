require 'rails_helper'

describe 'welcome/index' do
  subject do
    render template: "welcome/index.html.erb"
    rendered
  end

  context "with institution_param" do
    let(:institution_param){ :NS }
    before { allow(view).to receive(:institution_param).and_return institution_param }

    # check url_for
    it { is_expected.to include "http://test.host/?institution=NS" }
    # check current_institution
    it { is_expected.to include "New School Libraries" }
  end

  context "with institute_param" do
    let(:institute_param){ :NYUAD }
    before { allow(view).to receive(:institute_param).and_return institute_param }

    # check url_for
    it { is_expected.to include "http://test.host/?institute=NYUAD" }
    # check current_institution
    it { is_expected.to include "NYU Libraries" }
  end
end
