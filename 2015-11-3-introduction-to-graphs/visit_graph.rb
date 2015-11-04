class Graph
  attr_accessor :start

  def initialize(start)
    @start = start
  end
end

class Vertex
  attr_accessor :identifier
  attr_accessor :neighbors

  def initialize(identifier)
    @identifier = identifier
    @color = 0
  end

  def white?
    @color == 0
  end

  def gray?
    @color == 1
  end

  def black?
    @color == 2
  end

  def set_gray
    @color = 1
  end

  def set_black
    @color = 2
  end
end

def visit_graph(graph)
  def visit_vertex(v)
    v.set_gray
    v.neighbors.each do |n|
      visit_vertex(n) if n.white?
    end
    v.set_black
    puts v.identifier
  end

  visit_vertex graph.start
end

a = Vertex.new 'A'
b = Vertex.new 'B'
c = Vertex.new 'C'
d = Vertex.new 'D'
e = Vertex.new 'E'
f = Vertex.new 'F'

a.neighbors = [b, c]
b.neighbors = [a, d, e]
c.neighbors = [a, d, e]
d.neighbors = [b, c, e, f]
e.neighbors = [b, c, d, f]
f.neighbors = [d, e]

g = Graph.new a
visit_graph g