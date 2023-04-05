$("#container").hide();

let leaderboard = {};

$("document").ready(function () {
  function convertData(obj) {
    return Object.entries(obj).map(([id, { name, amount }]) => ({
      id,
      name,
      amount,
    }));
  }

  function sortData(data) {
    const sortedData = data.sort((a, b) => b.amount - a.amount);
    return sortedData.slice(0, 5);
  }

  function updateLeaderboard(data) {
    const leaderboardContainer = document.getElementById("leaderboard-list");
    leaderboardContainer.innerHTML = "";

    if (data.length === 0) {
      const li = document.createElement("li");
      li.innerHTML = "No one has collected any eggs yet!";
      leaderboardContainer.appendChild(li);
      return;
    }

    data.forEach((person) => {
      const li = document.createElement("li");
      li.innerHTML = `<span>${person.name}</span> - <span>${person.amount} egg/s</span>`;
      leaderboardContainer.appendChild(li);
    });
  }

  window.addEventListener("message", function (event) {
    let data = event.data;

    if (data.type === "toggle") {
      if (data.status === true) {
        leaderboard = data.leaderboard;
        let clean = convertData(leaderboard);
        let sorted = sortData(clean);
        updateLeaderboard(sorted);
        $("#container").fadeIn(250);
      } else {
        $("#container").fadeOut(250);
      }
    } else if (data.type === "update") {
      leaderboard = data.leaderboard;
      let clean = convertData(leaderboard);
      let sorted = sortData(clean);
      updateLeaderboard(sorted);
    }
  });
});
