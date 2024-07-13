/* import { html, render } from 'lit-html';
import { innova_aqua_icp_backend } from 'declarations/innova-aqua-icp-backend';
import logo from './logo2.svg';

class App {
  greeting = '';

  constructor() {
    this.#render();
  }

  #handleSubmit = async (e) => {
    e.preventDefault();
    const name = document.getElementById('name').value;
    this.greeting = await innova_aqua_icp_backend.greet(name);
    this.#render();
  };

  #render() {
    let body = html`
      <main>
        <img src="${logo}" alt="DFINITY logo" />
        <br />
        <br />
        <form action="#">
          <label for="name">Enter your name: &nbsp;</label>
          <input id="name" alt="Name" type="text" />
          <button type="submit">Click Me!</button>
        </form>
        <section id="greeting">${this.greeting}</section>
      </main>
    `;
    render(body, document.getElementById('root'));
    document
      .querySelector('form')
      .addEventListener('submit', this.#handleSubmit);
  }
}

export default App; */

import { html, render } from "lit-html";
import Chart from "chart.js/auto";

class App {
	// Simulated percentage of water fill
	percentageFilled = 25; // Example percentage of the water fill

	constructor() {
		this.#render();
		this.#renderChart();
	}

	#renderChart() {
		const ctx = document.getElementById("myChart").getContext("2d");
		new Chart(ctx, {
			type: "pie",
			data: {
				labels: ["Lleno", "Restante"],
				datasets: [
					{
						data: [
							this.percentageFilled,
							100 - this.percentageFilled,
						],
						backgroundColor: [
							"rgba(54, 162, 235, 0.6)", // Filled portion color
							"rgba(211, 211, 211, 0.6)", // Empty portion color
						],
						borderColor: [
							"rgba(54, 162, 235, 1)",
							"rgba(211, 211, 211, 1)",
						],
						borderWidth: 1,
					},
				],
			},
			options: {
				plugins: {
					tooltip: {
						callbacks: {
							label: function (context) {
								let label = context.label || "";
								if (label) {
									label += ": ";
								}
								label += context.raw + "%";
								return label;
							},
						},
					},
				},
			},
		});
	}

	#render() {
		let body = html`
			<body style="margin: 0; padding: 0;">
				<main
					style="display: flex; justify-content: center; align-items: center; height: 100vh width:100vh;"
				>
					<div style="text-align: center;">
						<header style="margin-bottom: 20px;">
							<h1>
								Capacidad restante:
								${100 - this.percentageFilled}%
							</h1>
						</header>
						<canvas id="myChart" width="400" height="400"></canvas>
					</div>
				</main>
			</body>
		`;
		render(body, document.getElementById("root"));
	}
}

export default App;
