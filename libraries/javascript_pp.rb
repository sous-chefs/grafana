module JavascriptPP
  def self.pprint(obj, indent=1)
    case obj
    when Hash
      res = "{\n"
      obj.each do |k,v|
        res += '  ' * indent
        res += k.to_s + ': '
        res += pprint(v, indent+1)
        res += ",\n"
      end
      res.gsub!(/,\n$/, "\n")
      res += '  ' * (indent - 1)
      res += '}'
    else
      res = obj.to_s
    end
    res
  end
end
