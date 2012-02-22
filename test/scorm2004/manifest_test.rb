require_relative '../helper'

module Scorm2004
  class ManifestTest < ActiveSupport::TestCase
    context 'Manifest' do
      should 'be a module' do
        assert_kind_of Module, Manifest
      end

      should 'have its own exception class' do
        assert_kind_of StandardError, Manifest::Error.new
      end
    end
  end
end
