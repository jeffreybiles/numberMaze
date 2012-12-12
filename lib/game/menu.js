// ig.module('game.menu').requires('impact.game')
// .defines(function() {
//   menu = function() {
//     ig.gui.element.add({
//       name: 'pause',
//       group: 'main',
//       size: {x: 100, y: 100},
//       pos: {x: ig.system.width - 120, y: 20},
//       toggle: true,
//       active: false,
//       state: {
//         normal: {
//           image: new ig.Image('media/redButton.png'),
//           tile: 0,
//           tileSize: 100
//         },
//         active: {
//           image: new ig.Image('media/greenButton.png'),
//           tile: 0,
//           tileSize: 100
//         }
//       },
//       click: function(){
//         ig.gui.element.action('toggleGroup', 'pauseMenu')
//         ig.game.togglePause()
//       }
//     }),

//     ig.gui.element.add({
//       name: 'retreatToCenter',
//       group: 'pauseMenu',
//       size: {x: 400, y: 400},
//       pos: {x: 100, y: 200},
//       state: {
//         normal: {
//           image: new ig.Image('media/retreatToCenter.png')
//         }
//       },
//       click: function(){
//         ig.game.goToCenter()
//         ig.game.togglePause()
//         ig.gui.element.action('hideGroup', 'pauseMenu')
//       }
//     }),

//     ig.gui.element.add({
//       name: 'killEverything',
//       group: 'pauseMenu',
//       size: {x: 400, y: 400},
//       pos: {x: 500, y: 200},
//       state: {
//         normal: {
//           image: new ig.Image('media/resetAllData.png')
//         }
//       },
//       click: function(){
//         ig.game.resetEverything()
//       }
//     })
//   }
// })