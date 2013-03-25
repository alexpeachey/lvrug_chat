require 'spec_helper'

describe User do
  context 'when validating' do
    subject(:user) { build(:user, params) }
    let(:params) {{}}

    context 'with the default factory' do
      specify { user.should be_valid }
    end

    context 'without a uid' do
      let(:params) {{uid: nil}}
      specify { user.should be_invalid }
    end

    context 'with a duplicate uid' do
      let(:params) {{uid: '123456'}}
      before { create(:user, uid: '123456') }
      specify { user.should be_invalid }
    end

    context 'without a name' do
      let(:params) {{name: nil}}
      specify { user.should be_invalid }
    end
  end

  context 'when using omniauth' do
    describe '.from_omniauth' do
      context 'when the user does not yet exist' do
        it 'should create a new user' do
          expect { User.from_omniauth({ 'uid' => '123456', 'info' => { 'nickname' => 'tester' } }) }.to change(User, :count).by(1)
        end
      end

      context 'when the user does exist' do
        let!(:user) { create(:user, uid: '123456') }

        it 'should not create a new user' do
          expect { User.from_omniauth({ 'uid' => '123456', 'info' => { 'nickname' => 'tester' } }) }.to_not change(User, :count).by(1)
        end

        it 'should find the existing user' do
          User.from_omniauth({ 'uid' => '123456', 'info' => { 'nickname' => 'tester' } }).id.should == user.id
        end
      end
    end
  end
end
