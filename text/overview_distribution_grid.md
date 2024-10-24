### Organizing Large Amounts of Data to be Informative 

CA's grid is highly complex and substations provide to a wide breadth of customers. For this reason, a single substation can have over a thousand distribution circuits, making the visualization process overwhelming and a bit tedious. To alleviate visual overload and gain distirbution level insights, we will be employing categorized color coding, and binning to simplify our visualization.

We will be grouping by categorized substation (sub_name) and assigning a color based on the substation's approximate distribution voltage. The colorblind friendly palette we will be using for our substations was provided by [David Nichols here](https://davidmathlogic.com/colorblind/#%23332288-%23117733-%2344AA99-%2388CCEE-%23DDCC77-%23CC6677-%23AA4499-%23882255). Once this is complete, a color ramp will be generated for each circuit (circuit_id) within a substation. For substations with more than 256 distinct line segments, binning will be employed to assign each circuit_id a color from the color ramp. 


### Incorporating Rooftop Solar Potential for DER

*Very rough, will have citations added soon*

Distributed energy resources (DER) are a cost effective supply demand solution that provides local access to clean energy and increases climate resiliency.
Benefits of DER here.

It is important to include all communities in order to plan an effective decarbonization transition. 
More about meeting energy demands ethically.

For this reason, I have included Google's Project Sunroof (add link here) data to assist in the planning and development of rooftop solar DER.