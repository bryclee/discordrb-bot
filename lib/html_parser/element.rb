class Element
    attr_accessor :content
    attr_accessor :parent
    attr_reader :tag
    attr_reader :id
    attr_reader :children
    attr_reader :selector
    
    def initialize(tag = nil)
        @tag = tag
        @content = ""
        @parent = nil
        @children = []
        @classes = []
        @id = nil
    end
    
    # Parse an html element opening tag (eg. <span class="..." id="...">) and
    # get the tag, class, and id from it.
    # Returns self.
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
        
        return self
    end
    
    # Add a child to element's children list
    def add(child)
        @children << child
        child.parent = self
        return child
    end
    
    # Get/setters for element class
    def classes
        return @classes.clone
    end
    
    def has_class?(name)
        return !@classes.index(name).nil?
    end
    
    # Search self and children for element with tag as type
    def find_element(type)
        elements = []
        
        if @tag == type
            elements << self
        end
        
        for child in @children
            elements.concat(child.find_element(type))
        end
        
        return elements
    end
        
    # Return the selector string of Element instance only
    def selector()
        selector = @tag
        if @classes.length
            classes.each {|cls| selector << '.' << cls}
        end
        
        unless @id.nil?
            selector << '#' << @id
        end
        
        return selector
    end
    
    # Test element to see if it matches selector
    def find_selector(selector)
        
    end

end
