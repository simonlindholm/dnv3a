
;(function() {
"use strict";

window.MenuView = View.extend({
	id: 'menuview',

	goDuel: function() {
		alert("My God, it's full of cards!");
	},

	goDeck: function() {
		alert("I'm sorry Dave. I'm afraid I can't do that.");
	},

	init: function() {
		this._super();

		Commands.setMap(this, [
			[10, 'd', "Duel", this.goDuel],
			[11, 'm', "Modify deck", this.goDeck],
			[100, 'q', "Log out", doLogout],
		]);
	}
});

})();
