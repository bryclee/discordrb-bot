class Element
    attr_accessor :content
    attr_reader :tag
    attr_accessor :parent
    attr_reader :id
    attr_reader :children
    
    def initialize(tag = nil)
        @tag = tag
        @content = ""
        @parent = nil
        @children = []
        @classes = []
        @id = ""
    end
    
    def from_string(html)
        match_tag = /^<(?<tag>\w*).*>$/.match(html)
        if match_tag.nil?
            raise Exception.new('Element tag not found')
        else
            @tag = match_tag[:tag]
        end
        
        match_class = /class\="(?<class>[\w\s]*)"/.match(html)
        match_id = /id\="(?<id>.*[^"])"/.match(html)
        
        if !match_class.nil?
            @classes = match_class[:class].split(' ')
        end
        if !match_id.nil?
            @id = match_id[:id]
        end
        
        self
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
