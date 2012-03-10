require_relative '../../helper'

module Scorm2004
  module Manifest
    class CustomErrorTest < ActiveSupport::TestCase
      context 'Visitor including the CustomError module' do
        class Visitor
          include VisitorPattern
          include CustomError
        end

        setup do
          @v = Visitor.new
        end

        should 'have its own error class' do
          assert_kind_of Scorm2004::Manifest::Error, "#{@v.class}::Error".constantize.new
        end

        should 'have its own error method' do
          assert @v.respond_to? :error
        end

        context 'error method' do
          should 'raise its own exceptoin' do
            assert_raise "#{@v.class}::Error".constantize do
              @v.error('dummy message')
            end
          end

          should 'set message' do
            begin
              message = 'something wrong'
              @v.error(message)
            rescue "#{@v.class}::Error".constantize => e
              assert_equal message, e.message
            end
          end
        end
      end
    end
  end
end
