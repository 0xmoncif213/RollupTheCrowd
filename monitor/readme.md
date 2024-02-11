# Monitor 

The `Monitor/`directory contains the scripts and files related to monitoring and tracking functionalities. It provides a ready monitoring dashboard to collect and visualize geth metrics with prometheus and grafana.

![](https://img.shields.io/badge/Note-Important-red)
To configure the monitoring dashboard with zkSync node, you have to:
-   Enter the Docker image of the zkSync local node.
-   Update the script responsible for launching the Geth node (expose monitoring ports).
-   Save the modified image, then restart it.
