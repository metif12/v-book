module main

// roadmap generator.
//
// A `roadmap` fence holds the path through the book as compact lines — a stage
// name at the left margin, then one node per line under it, with the label and
// the chapter it links to:
//
//	```roadmap
//	Stage 1 — The language
//	  Install V and run your first program | ch01-01-installation
//	```
//
// The fence is drawn as inline SVG by site/templates/roadmap.svg, one column
// per stage, with every node a link into the book. This file does the layout:
// where each column sits, how tall each node has to be for its label, and
// which chapter a node opens. The template does the markup.
//
// A node whose chapter has been opened is marked, and the browser keeps that
// between visits, so the picture doubles as a progress map.

// roadmap_fence is the fence language that triggers the diagram.
const roadmap_fence = 'roadmap'

// RoadmapView is everything the template reads.
struct RoadmapView {
mut:
	width    int
	height   int
	pad_x    int
	pad_y    int
	col_w    int
	header_h int
	line_h   int
	stages   []RoadmapStageView
}

// RoadmapStageView is one column, already placed.
struct RoadmapStageView {
mut:
	name      string
	name_x    int
	name_y    int
	x         int
	arrow_x   int
	arrow_y   int
	arrow_end int
	has_next  bool
	nodes     []RoadmapNodeView
}

// RoadmapNodeView is one step, already placed and wrapped.
struct RoadmapNodeView {
mut:
	label  string
	target string
	y      int
	height int
	text_x int
	lines  []RoadmapLineView
}

// RoadmapLineView is one wrapped line of a label, with where it sits.
struct RoadmapLineView {
	text string
	y    int
}

// RoadmapNode is one step as written in the fence.
struct RoadmapNode {
	label string
	href  string
}

// RoadmapStage is a column as written in the fence.
struct RoadmapStage {
mut:
	name  string
	nodes []RoadmapNode
}

// parse_roadmap reads the fence body into stages and nodes.
fn parse_roadmap(lines []string) []RoadmapStage {
	mut stages := []RoadmapStage{}
	mut inside := false
	for line in lines {
		if line.trim_space() == '' {
			continue
		}
		if line.starts_with(' ') || line.starts_with('\t') {
			if !inside {
				continue
			}
			row := line.trim_space()
			mut label := row
			mut href := ''
			if row.contains('|') {
				bar := row.index('|') or { -1 }
				label = row[..bar].trim_space()
				href = row[bar + 1..].trim_space()
			}
			mut stage := stages[stages.len - 1]
			stage.nodes << RoadmapNode{
				label: label
				href:  href
			}
			stages[stages.len - 1] = stage
			continue
		}
		inside = true
		stages << RoadmapStage{
			name:  line.trim_space()
			nodes: []RoadmapNode{}
		}
	}
	return stages
}

// render_roadmap lays the fence out and draws it from the template.
fn render_roadmap(fence []string) string {
	stages := parse_roadmap(fence)
	pad_x := 12
	pad_y := 12
	col_w := 224
	col_gap := 44
	header_h := 38
	node_gap := 12
	line_h := 17
	mut roadmap := RoadmapView{
		width:    pad_x * 2 + stages.len * col_w + (stages.len - 1) * col_gap
		pad_x:    pad_x
		pad_y:    pad_y
		col_w:    col_w
		header_h: header_h
		line_h:   line_h
		height:   pad_y * 2 + header_h + node_gap
	}
	for s, stage in stages {
		x := pad_x + s * (col_w + col_gap)
		mut column := RoadmapStageView{
			name:      stage.name
			x:         x
			name_x:    x + 14
			name_y:    pad_y + 24
			has_next:  s + 1 < stages.len
			arrow_x:   x + col_w + 8
			arrow_y:   pad_y + header_h / 2
			arrow_end: x + col_w + col_gap - 14
		}
		mut y := pad_y + header_h + node_gap
		for node in stage.nodes {
			wrapped := wrap_label(node.label, col_w - 26)
			// A node names its chapter the way SUMMARY.md does, with or without
			// the .md suffix; the link that reaches it always ends in .html.
			file := if node.href.ends_with('.html') {
				node.href
			} else if node.href.ends_with('.md') {
				node.href.replace('.md', '.html')
			} else {
				node.href + '.html'
			}
			mut node_view := RoadmapNodeView{
				label:  node.label
				target: if node.href == '' { '' } else { base_path + file }
				y:      y
				height: 16 + wrapped.len * line_h
				text_x: x + 13
			}
			for l, text in wrapped {
				node_view.lines << RoadmapLineView{
					text: text
					y:    y + 24 + l * line_h
				}
			}
			column.nodes << node_view
			y += node_view.height + node_gap
		}
		roadmap.stages << column
		each := pad_y + header_h + node_gap + column_height(column, node_gap) + pad_y * 2
		if each > roadmap.height {
			roadmap.height = each
		}
	}
	return $tmpl('templates/roadmap.svg', roadmap)
}

// column_height is how tall one column's nodes are, gaps included.
fn column_height(column RoadmapStageView, node_gap int) int {
	mut total := 0
	for node in column.nodes {
		total += node.height + node_gap
	}
	return total
}

// wrap_label breaks a label into lines that fit a node, at word boundaries, and
// never longer than three of them. A glyph in the roadmap's font is roughly
// seven pixels wide, so a label of N pixels holds N / 7 characters.
fn wrap_label(label string, width int) []string {
	per_line := if width / 7 < 8 { 8 } else { width / 7 }
	mut out := []string{}
	mut current := ''
	for word in label.split(' ') {
		if word.len > per_line {
			if current.trim_space() != '' {
				out << current.trim_space()
			}
			current = ''
			mut chunk := ''
			for c in word {
				chunk += c.ascii_str()
				if chunk.len >= per_line {
					out << chunk
					chunk = ''
				}
			}
			current = chunk
			continue
		}
		if current != '' && current.len + 1 + word.len > per_line {
			out << current.trim_space()
			current = word
			continue
		}
		if current == '' {
			current = word
		} else {
			current += ' ' + word
		}
	}
	if current.trim_space() != '' {
		out << current.trim_space()
	}
	if out.len > 3 {
		mut cut := out[..3].clone()
		cut[2] = cut[2] + '…'
		return cut
	}
	return out
}
