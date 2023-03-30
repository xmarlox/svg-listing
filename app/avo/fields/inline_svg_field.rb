class InlineSvgField < Avo::Fields::FileField
  def initialize(name, **args, &block)
    super(name, **args, &block)
  end
end
