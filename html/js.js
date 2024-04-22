// Portal Exeunt



function closeBattlepass() {
    $.post("http://allsides_sobrenatural/closeNUI", JSON.stringify({}));
}


$(function() {
	window.addEventListener('message', function(event) {
		var item = event.data;
		console.log(item)

		if (item.skill_2) {
			console.log(item.skill_2)

		}
		if (item.skill_3) {
			console.log(item.skill_3)
		}
		if (item.skill_4) {
			console.log(item.skill_4)
		}
		
		if (item.type == "show") {
			document.body.style.display = item.enable ? "block" : "none";   
		}
		if (item.type == "hide") {
            document.body.style.display = "none";
		}

        if (item.type == "SKILL-2") {
			console.log(`skill 22222`)
			var skill = "well";
			var skillName = "TESTE5";
			var cooldown = 40;
			var timeout = cooldown * 1000;
			var timeleft = cooldown;
			var sec = cooldown + "s";
			var btn = $(this);
			btn.prop("disabled", true);
			document.getElementById(skill).innerHTML = timeleft;
    		damage("mana",40)
			var downloadTimer = setInterval(function () {
				timeleft -= 1;
				if (timeleft <= 0) {
					clearInterval(downloadTimer);
					document.getElementById(skill).innerHTML = skillName;
				} else {
					document.getElementById(skill).innerHTML = timeleft;
				}
			}, 1000);
			setTimeout(function () {
				btn.prop("disabled", false);
			}, timeout);
            
		}
        if (item.type == "SKILL-3") {
			console.log(`skill 333`)
			var skill = "portal";
            var skillName = "R";
            var cooldown = 10;
         
            var timeout = cooldown * 1000;
            var timeleft = cooldown;
            var sec = cooldown + "s";
            var btn = $(this);
            btn.prop("disabled", true);
            document.getElementById(skill).innerHTML = timeleft;
            damage("mana",30)
            var downloadTimer = setInterval(function () {
                timeleft -= 1;
                if (timeleft <= 0) {
                    clearInterval(downloadTimer);
                    document.getElementById(skill).innerHTML = skillName;
                } else {
                    document.getElementById(skill).innerHTML = timeleft;
                }
            }, 1000);
            setTimeout(function () {
                //btn.prop("disabled", false);
            }, timeout); 



           
		}
        if (item.type == "SKILL-4") {
			console.log(`skill 4`)
			var skill = "breach";
			var skillName = "TESTE2";
			var cooldown = 90;
			var audio = breachAudio;
		
			var timeout = cooldown * 1000;
			var timeleft = cooldown;
			var btn = $(this);
			btn.prop("disabled", true);
			damage("mana",25)
			document.getElementById(skill).innerHTML = timeleft;
			var downloadTimer = setInterval(function () {
				timeleft -= 1;
				if (timeleft <= 0) {
					clearInterval(downloadTimer);
					document.getElementById(skill).innerHTML = skillName;
				} else {
					document.getElementById(skill).innerHTML = timeleft;
				}
			}, 1000);
			setTimeout(function () {
				btn.prop("disabled", false);
				audio.play();
			}, timeout);
           
		}
        if (item.type == "SKILL-5") {
			console.log(`skill 5`)
			var skill = "well";
			var skillName = "TESTE5";
			var cooldown = 40;
		

			var timeout = cooldown * 1000;
			var timeleft = cooldown;
			var sec = cooldown + "s";
			var btn = $(this);
			btn.prop("disabled", true);
			document.getElementById(skill).innerHTML = timeleft;
    		damage("mana",40)
			var downloadTimer = setInterval(function () {
				timeleft -= 1;
				if (timeleft <= 0) {
					clearInterval(downloadTimer);
					document.getElementById(skill).innerHTML = skillName;
				} else {
					document.getElementById(skill).innerHTML = timeleft;
				}
			}, 1000);
			setTimeout(function () {
				btn.prop("disabled", false);
			}, timeout);
           
		}
	});
    $("body").on("keyup", function (key) {
		if (key.which == 27){
			closeBattlepass();
            console.log("solicitando fechar")
		}
	});

});




// Well of Corruption
$("button.cooldown#well").click(function () {
	
});


// Veil
$("button.cooldown#veil").click(function () {
	var skill = "veil";
	var skillName = "TESTE";
	var cooldown = 72;
	var audio = veilAudio;

	var timeout = cooldown * 1000;
	var timeleft = cooldown;
	var btn = $(this);
	btn.prop("disabled", true);
	document.getElementById(skill).innerHTML = timeleft;
    damage("mana",10)
	var downloadTimer = setInterval(function () {
		timeleft -= 1;
		if (timeleft <= 0) {
			clearInterval(downloadTimer);
			document.getElementById(skill).innerHTML = skillName;
		} else {
			document.getElementById(skill).innerHTML = timeleft;
		}
	}, 1000);
	setTimeout(function () {
		btn.prop("disabled", false);
		audio.play();
	}, timeout);
});
$("button.cooldown#veil1").click(function () {
	var skill = "veil1";
	var skillName = "TESTE1";
	var cooldown = 72;
	var audio = veilAudio;

	var timeout = cooldown * 1000;
	var timeleft = cooldown;
	var btn = $(this);
	btn.prop("disabled", true);
	document.getElementById(skill).innerHTML = timeleft;
    damage("mana",10)
	var downloadTimer = setInterval(function () {
		timeleft -= 1;
		if (timeleft <= 0) {
			clearInterval(downloadTimer);
			document.getElementById(skill).innerHTML = skillName;
		} else {
			document.getElementById(skill).innerHTML = timeleft;
		}
	}, 1000);
	setTimeout(function () {
		btn.prop("disabled", false);
		audio.play();
	}, timeout);
});


// Ghastly Breach
$("button.cooldown#breach").click(function () {

});



let stats = {
    health: { current: 20, max: 100, tick: 5000 },
    mana: { current: 10, max: 100, tick: 2000 },
    stamina: { current: 10, max: 100, tick: 1000 }
  }
  
  function statPercent(stat) {
    return `${(stats[stat].current / stats[stat].max) * 100}%`
  }
  
  function damage(stat, amount = 10) {
    let current = stats[stat].current
    let max = stats[stat].max
    stats[stat].current -= current > 0 ? amount : 0
    setStat(stat)
  }
  
  function heal(stat, amount = 3) {
    let current = stats[stat].current
    let max = stats[stat].max
    stats[stat].current += current < max ? amount : 0
    setStat(stat)
  }
  
  function setStat(stat) {
    bar = $(`.${stat} > div`)
    text = $(`.${stat} > span`)
    percent = statPercent(stat)
    bar.css('width', percent)
    text.text(`${stats[stat].current}/${stats[stat].max}`)
  }
  
  setStat('health')
  setStat('mana')
  setStat('stamina')
  
  $('.damage').click(evt => {
    damage(evt.target.dataset.stat)
  })
  
  setInterval(heal, stats.health.tick, 'health')
  setInterval(heal, stats.mana.tick, 'mana')
  setInterval(heal, stats.stamina.tick, 'stamina')
  