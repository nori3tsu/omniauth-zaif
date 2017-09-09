require 'spec_helper'

describe OmniAuth::Strategies::Zaif do
  let(:request) { double('Request', :params => {}, :cookies => {}, :env => {}) }

  subject do
    args = ['channel_id', 'secret', @options || {}].compact
    OmniAuth::Strategies::Zaif.new(*args).tap do |strategy|
      allow(strategy).to receive(:request) {
        request
      }
    end
  end

  describe 'client options' do
    it 'should have correct name' do
      expect(subject.options.name).to eq('zaif')
    end

    it 'should have correct site' do
      expect(subject.options.client_options.site).to eq('https://zaif.jp')
    end

    it 'should have correct authorize url' do
      expect(subject.options.client_options.authorize_url).to eq('https://zaif.jp/oauth')
    end

    it 'should have correct token url' do
      expect(subject.options.client_options.token_url).to eq('https://oauth.zaif.jp/v1/token')
    end
  end

  describe 'uid' do
    before do
      allow(subject).to receive(:raw_info).and_return(raw_info_hash)
    end

    it 'should returns the uid' do
      expect(subject.uid).to eq(raw_info_hash['mid'])
    end
  end

  describe 'info' do
    before do
      allow(subject).to receive(:raw_info).and_return(raw_info_hash)
    end

    it 'should returns the name' do
      expect(subject.info[:name]).to eq(raw_info_hash['name'])
    end
  end

  describe 'request_phase' do
    context 'with no request params set' do
      before do
        allow(subject).to receive(:request).and_return(
          double('Request', {:params => {}})
        )
        allow(subject).to receive(:request_phase).and_return(:whatever)
      end

      it 'should not break' do
        expect { subject.request_phase }.not_to raise_error
      end
    end
  end

end

private

def raw_info_hash
  {
    'uid'           => 'hoge',
    'name'   => 'Foo Bar'
  }
end
