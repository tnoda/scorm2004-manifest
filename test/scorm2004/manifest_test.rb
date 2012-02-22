require_relative '../helper'

module Scorm2004
  class ManifestTest < ActiveSupport::TestCase
    context 'Manifest' do
      should 'be a module' do
        assert_kind_of Module, Manifest
      end
    end
  end
end
