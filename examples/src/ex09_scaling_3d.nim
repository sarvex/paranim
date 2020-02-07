import nimgl/opengl
import paranim/gl
import examples_common
from bitops import bitor

var entity: ThreeDEntity
let tx, ty = 100f

proc init*(game: var Game) =
  assert glInit()

  glEnable(GL_BLEND)
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA)
  glEnable(GL_CULL_FACE)
  glEnable(GL_DEPTH_TEST)

  entity = compile(game, initThreeDEntity(f3d, f3dColors))

proc tick*(game: Game) =
  glClearColor(1f, 1f, 1f, 1f)
  glClear(GLbitfield(bitor(GL_COLOR_BUFFER_BIT.ord, GL_DEPTH_BUFFER_BIT.ord)))
  glViewport(0, 0, GLsizei(game.frameWidth), GLsizei(game.frameHeight))

  let
    widthRatio = float(game.frameWidth) / float(game.windowWidth)
    heightRatio = float(game.frameHeight) / float(game.windowHeight)
    x = game.mouseX * widthRatio - tx
    y = game.mouseY * heightRatio - ty
    rx = x / float(game.frameWidth)
    ry = y / float(game.frameHeight)

  var e = entity
  e.project(0f, float(game.frameWidth), float(game.frameHeight), 0f, 400f, -400f)
  e.translate(tx, ty, 0f)
  e.rotateX(degToRad(40f))
  e.rotateY(degToRad(25f))
  e.rotateZ(degToRad(325f))
  e.scale(rx, ry, 1f)

  render(game, e)
