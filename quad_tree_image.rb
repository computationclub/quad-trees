class Leaf
  def initialize(color)
    @color = color
  end

  def to_s(size = 1)
    ([(@color ? "#" : ".") * size] * size).join("\n")
  end

  def rotate
    self
  end
end

class QuadTree
  def initialize(ne, nw, sw, se)
    @ne = ne
    @nw = nw
    @se = se
    @sw = sw
  end

  def to_s(size)
    return "/" if size == 1
    (@nw.to_s(size/2).lines.map(&:chomp).zip(@ne.to_s(size/2).lines.map(&:chomp)).map(&:join) +
     @sw.to_s(size/2).lines.map(&:chomp).zip(@se.to_s(size/2).lines.map(&:chomp)).map(&:join)).join("\n")
  end

  def rotate
    QuadTree.new(@se.rotate, @ne.rotate, @nw.rotate, @sw.rotate)
  end
end

w = Leaf.new(false)
b = Leaf.new(true)

cat = QuadTree.new(
  QuadTree.new(w,w,QuadTree.new(w,b,b,w),w),
  QuadTree.new(w,w,w,QuadTree.new(w,w,b,b)),
  QuadTree.new(QuadTree.new(b,b,w,w),w,w,w),
  QuadTree.new(QuadTree.new(w,w,b,b),b,QuadTree.new(b,w,w,b),b)
)

puts cat.to_s(8)
puts "________"
puts cat.rotate.to_s(8)
puts "--------------------------------------------------------------------------------"
puts QuadTree.new(
  cat.rotate.rotate.rotate,
  cat,
  cat.rotate,
  cat.rotate.rotate
).to_s(16)
