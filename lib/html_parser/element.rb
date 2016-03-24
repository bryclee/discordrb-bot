class Element
    attr_accessor :tag
    attr_accessor :content
    attr_accessor :parent
    
    def initialize(tag = nil, classes = "", content = nil)
        @tag = tag
        @classlist = classes.split(" ")
        @content = content
        @parent = nil
        @children = []
    end
    
    def add(child)
        @children << child
        child.parent = self
        return child
    end
    
    # TODO: class setters and getters
end