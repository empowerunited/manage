require 'spec_helper'

module Manage
  module Fields
    describe Filter do

      it 'gets the right field value by using the field name represented as symbol' do
        test_object = Object.new

        mock_value = 'I am here!!!'
        test_object.stub(:me) {mock_value}

        value = Filter.field_value(test_object, :me)
        value.should eq(mock_value)
      end

      it 'gets the right field value by using the field name represented as string' do
        test_object = Object.new

        mock_value = 'I am you and you are me'
        test_object.stub(:me) {mock_value}

        value = Filter.field_value(test_object, 'me')
        value.should eq(mock_value)
      end

      it 'gets the right field value by using the composite field of the type "a.b.c"' do
        test_object = Object.new

        mock_value = 'Deep hidden stuff!'
        test_object.stub(:me) do
          test_object_level_two = Object.new
          test_object_level_two.stub(:you) do
            test_object_level_three = Object.new
            test_object_level_three.stub(:we) {mock_value}
            test_object_level_three
          end

          test_object_level_two
        end

        value = Filter.field_value(test_object, 'me.you.we')
        value.should eq(mock_value)
      end

      it 'can work with relations one level deep' do
        Filter.stub(:'_is_field_relation?') {true}

        test_object = Object.new
        test_object.stub(:list) {[Struct.new(:id).new(5), Struct.new(:id).new(6)]}

        value = Filter.field_value(test_object, 'list')
        value.should_not be_nil
        value.should be_a(String)
        value.should include('5', '6')
      end

      it 'displays relation values in custom format' do
        Filter.stub(:'_is_field_relation?') {true}

        test_object = Object.new
        test_object.stub(:list) {[
          Struct.new(:id, :name).new(5, 'meddle'),
          Struct.new(:id, :name).new(6, 'nickolay')
        ]}

        field_data = {'list' => {
          format: ->(obj) { obj.name }
        }}

        value = Filter.field_value(test_object, field_data)
        value.should_not be_nil
        value.should be_a(String)
        value.should include('meddle', 'nickolay')
      end

    end
  end
end
