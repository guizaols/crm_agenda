require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

Dir.glob(RAILS_ROOT + '/app/models/*.rb').each do |model_file|

  model = model_file.match(%r{([\w_]+)\.rb$})[1].camelize.constantize

  describe model do

    it 'deve possuir todas as fixtures válidas' do
      model.all.each do |instance|
        violated "Fixture #{instance.inspect} deve ser válida!" unless instance.valid?
      end
    end

  end

end