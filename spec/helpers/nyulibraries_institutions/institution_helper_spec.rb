require 'rails_helper'

describe NyulibrariesInstitutions::InstitutionHelper do
  describe "url_for" do
    subject{ helper.url_for(params) }
    let(:params){ {controller: "welcome"} }

    pending

    # context "with institution_param" do
    #   let(:institution_param){ "NS" }
    #   before { allow(helper).to receive(:institution_param).and_return institution_param }
    #
    #   it { is_expected.to eq "/?institution=NS" }
    # end
    #
    # context "with institute_param" do
    #   let(:institute_param){ "NYUAD" }
    #   before { allow(helper).to receive(:institute_param).and_return institute_param }
    # end
  end

  describe "institutional_stylesheet" do
    subject{ helper.institutional_stylesheet }
    let(:institution){ double Institutions::Institution, views: ({"css" => stylesheet}).with_indifferent_access }
    let(:stylesheet){ "some_stylesheet" }
    before do
      allow(helper).to receive(:current_institution).and_return institution
    end

    it "should call stylesheet_link_tag" do
      expect(helper).to receive(:stylesheet_link_tag).with stylesheet
      subject
    end
  end

  describe "views" do
    subject{ helper.views }
    let(:institution){ double Institutions::Institution, views: views }
    let(:views){ ({a: "b", c: "d"}).with_indifferent_access }
    before do
      allow(helper).to receive(:current_institution).and_return institution
    end

    it { is_expected.to eq views }
  end

  describe "default_institution" do
    subject{ helper.default_institution }

    it { is_expected.to be_a Institutions::Institution }
    it { is_expected.to have_code :NYU }
  end

  describe "current_institution" do
    subject{ helper.current_institution }

    context "with institution_param" do
      let(:params){ {"institution" => "NYUAD"}.with_indifferent_access }
      before { allow(helper).to receive(:params).and_return params }

      it { is_expected.to be_a Institutions::Institution }
      it { is_expected.to have_code :NYUAD }
    end

    context "without institution_param" do
      let(:params){ {} }
      before { allow(helper).to receive(:params).and_return params }

      context "with institution_from_ip" do
        let(:institution_from_ip){ double Institutions::Institution }
        before { allow(helper).to receive(:institution_from_ip).and_return institution_from_ip }

        it { is_expected.to eq institution_from_ip }
      end

      context "without institution_from_ip" do
        before { allow(helper).to receive(:institution_from_ip).and_return nil }

        context "with institution_from_current_user" do
          let(:institution_from_current_user){ double Institutions::Institution }
          before { allow(helper).to receive(:institution_from_current_user).and_return institution_from_current_user }

          it { is_expected.to eq institution_from_current_user }
        end

        context "without institution_from_current_user" do
          before { allow(helper).to receive(:institution_from_current_user).and_return nil }

          it { is_expected.to be_a Institutions::Institution }
          it { is_expected.to have_code :NYU }
        end
      end
    end # end context "without institution_param"
  end # end describe "current_institution"

  describe "institution_from_ip" do
    subject{ helper.institution_from_ip }
    before { allow(helper).to receive(:request).and_return request }

    context "without request" do
      let(:request){ nil }

      it { is_expected.to eq nil }
    end

    context "with request" do
      let(:request){ double ActionDispatch::Request, remote_ip: remote_ip }
      let(:remote_ip){ "123.123.123.123" }

      context "given institution" do
        let(:institution1){ double(Institutions::Institution, ip_addresses: nil, code: :NYU, includes_ip?: false) }
        let(:institution2){ double(Institutions::Institution, ip_addresses: nil, code: :NYUAD, includes_ip?: false) }
        let(:institution3){ double(Institutions::Institution, ip_addresses: nil, code: :NS, includes_ip?: false) }
        let(:institutions) do
          {
            NYU: institution1,
            NYUAD: institution2,
            NS: institution3,
          }
        end
        before { allow(Institutions).to receive(:institutions).and_return institutions }

        context "matching request" do
          before do
            allow(institution2).to receive(:includes_ip?).with(remote_ip).and_return true
          end

          it { is_expected.to eq institution2 }
        end

        context "not matching request" do
          it { is_expected.to eq nil }
        end
      end

      context "without institutions" do
        let(:institutions){ {} }
        before { allow(Institutions).to receive(:institutions).and_return institutions }

        it { is_expected.to eq nil }
      end
    end
  end

  describe "institution_param_name" do
    subject{ helper.institution_param_name }

    it { is_expected.to eq "institution" }
  end

  describe "institution_from_current_user" do
    subject{ helper.institution_from_current_user }

    context "with current_user defined" do
      before do
        class DummyUser
          def self.first; end
        end
        helper.define_singleton_method(:current_user) do
          DummyUser.first
        end
        allow(DummyUser).to receive(:first).and_return user
      end

      context "and returns nil" do
        let(:user){ nil }

        it { is_expected.to eq nil }
      end

      context "and returns object without institution_code" do
        let(:user){ double DummyUser }

        it { is_expected.to eq nil }
      end

      context "and returns object with institution_code" do
        let(:user){ double DummyUser, institution_code: institution_code }
        before do
          class DummyUser
            def institution_code; end
          end
        end

        context "set to nil" do
          let(:institution_code){ nil }

          it { is_expected.to eq nil }
        end

        context "set to valid code" do
          let(:institution_code){ "NYUSH" }

          it { is_expected.to be_a Institutions::Institution }
          it { is_expected.to have_code institution_code }
        end

        context "set to invalid code" do
          let(:institution_code){ "other" }

          it { is_expected.to eq nil }
        end
      end
    end

    context "without current_user defined" do
      it { is_expected.to eq nil }
    end
  end


end
