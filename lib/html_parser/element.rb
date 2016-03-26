class Element
    attr_accessor :content
    attr_reader :tag
    attr_accessor :parent
    attr_reader :id
    attr_reader :children
    
    def initialize(html)
        match = /^<(?<tag>\w*).*>$/.match(html) # finish me please sir.
        if match.nil?
            raise Exception.new('Element tag not found')
        end
        
        @tag = match[:tag]
        @content = ""
        @parent = nil
        @children = []
        @classes = []
        @id = ""
        
        match_class = /class\="(?<class>[\w\s]*)"/.match(html)
        match_id = /id\="(?<id>.*[^"])"/.match(html)
        
        if !match_class.nil?
            @classes = match_class[:class].split(' ')
        end
        if !match_id.nil?
            @id = match_id[:id]
        end
    end
    
    def add(child)
        @children << child
        child.parent = self
        return child
    end
    
    # Get/setters for element class
    def classes
        return @classes
    end
    
    def has_class?(name)
        return !@classes.index(name).nil?
    end
end
