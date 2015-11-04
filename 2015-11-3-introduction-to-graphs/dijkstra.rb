class Vertex
  def initialize(id)
    @id = id
    @neighbors = []
  end

  def id
    @id
  end

  def neighbors
    @neighbors
  end

  def ==(other)
    @id == other.id
  end
end

class Edge
  def initialize(source, dest, length)
    @source = source
    @dest = dest
    @length = length
  end

  def source
    @source
  end

  def dest
    @dest
  end

  def length
    @length
  end
end

class Graph
  def initialize()
    @vertices = []
    @edges = []
  end

  def vertices
    @vertices
  end

  def length(source, dest)
    @edges.each do |e|
      if e.source == source && e.dest == dest
        return e.length
      end
    end

    0
  end

  # Create an edge between source and dest
  def tie(source, dest, length)
    @vertices << source unless @vertices.include? source
    source.neighbors << dest
    @vertices << dest unless @vertices.include? dest
    @edges << Edge.new(source, dest, length)
  end
end

# Data object returned after running Dijkstra
class DijkstraResult
  def initialize(source, dest, dist, prev)
    @distance = dist[dest.id]
    @path = []
    build_path prev, source, dest
  end

  def distance
    @distance
  end

  # Returns the path from source to dest
  def path
    @path
  end

  private

  # Builds path using the prev associative array
  def build_path(prev, source, current)
    @path = [current.id] + @path
    return if source == current
    build_path prev, source, prev[current.id]
  end
end

$MAX_VAL = 99999999

# Returns the closest node to source
def min_to_source(dist, prev, source, vertices)
  def min_to_source_aux(dist, prev, source, vertex)
    return $MAX_VAL if vertex.nil? # Hasn't been visited yet
    return 0 if vertex == source
    return dist[vertex.id] + min_to_source_aux(dist, prev, source, prev[vertex.id])
  end

  min = nil
  current_vertex = nil
  vertices.each do |v|
    value = min_to_source_aux(dist, prev, source, v)
    if min.nil? || value < min
      min = value
      current_vertex = v
    end
  end

  return current_vertex
end

def dijkstra(graph, source, dest)
  default_dist = $MAX_VAL
  dist = {} # Matches node to its distance to the source
  prev = {} # Matches node with its predecessor (in the shortest path)
  vertex_set = [] # Nodes that have not been visited yet

  # Initialize the different structures
  graph.vertices.each do |v|
    if v == source
      dist[v.id] = 0
    else
      dist[v.id] = default_dist
    end

    prev[v.id] = nil
    vertex_set << v
  end

  current_vertex = nil
  while vertex_set.length > 0
    if current_vertex.nil?
      current_vertex = source
    else
      current_vertex = min_to_source(dist, prev, current_vertex, vertex_set)
    end
    vertex_set.delete current_vertex

    current_vertex.neighbors.each do |v|
      alternative = dist[current_vertex.id] + graph.length(current_vertex, v)
      if alternative < dist[v.id] # A better route has been found
        dist[v.id] = alternative
        prev[v.id] = current_vertex
      end
    end
  end

  DijkstraResult.new source, dest, dist, prev
end

a = Vertex.new('A')
b = Vertex.new('B')
c = Vertex.new('C')
d = Vertex.new('D')
e = Vertex.new('E')
f = Vertex.new('F')

graph = Graph.new
graph.tie a, b, 5
graph.tie a, c, 3
graph.tie b, d, 15
graph.tie b, e, 8
graph.tie c, d, 45
graph.tie c, e, 2
graph.tie d, f, 10
graph.tie e, d, 4
graph.tie e, f, 60

result = dijkstra graph, a, f
print("#{result.distance} - #{result.path}\n")