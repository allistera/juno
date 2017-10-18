require 'test_helper'

class SitePolicyTest < ActiveSupport::TestCase
  describe 'user' do
    describe 'index' do
      it 'rejects outright' do
        refute SitePolicy.new(users(:joe), Site).index?
      end
    end

    describe 'show' do
      it 'allows if own organisation' do
        assert SitePolicy.new(users(:joe), sites(:one)).show?
      end

      it 'rejects if not own organisation' do
        refute SitePolicy.new(users(:joe), sites(:two)).show?
      end
    end

    describe 'create' do
      it 'allows if own organisation' do
        assert SitePolicy.new(users(:joe), sites(:one)).create?
      end

      it 'rejects if not own organisation' do
        refute SitePolicy.new(users(:joe), sites(:two)).create?
      end
    end

    describe 'update' do
      it 'rejects outright' do
        refute SitePolicy.new(users(:joe), sites(:one)).update?
      end
    end

    describe 'destroy' do
      it 'allows if own organisation' do
        assert SitePolicy.new(users(:joe), sites(:one)).destroy?
      end

      it 'rejects if not own organisation' do
        refute SitePolicy.new(users(:joe), sites(:two)).destroy?
      end
    end

    describe 'checks' do
      it 'allows if own organisation' do
        assert SitePolicy.new(users(:joe), sites(:one)).checks?
      end

      it 'rejects if not own organisation' do
        refute SitePolicy.new(users(:joe), sites(:two)).checks?
      end
    end
  end
end
