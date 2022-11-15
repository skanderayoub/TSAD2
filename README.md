# Computation time
---
This feature returns the average computation time (in seconds) for a single timetsep prediction on each trained DNN.

**Steps:**
---
1. Select a dataset
2. Preprocess the data.
3. Select and tune one or multiple DNNs and train them.
4. On the detection tab, select a faulty data and run the detection for all trained models.
5. Select the "Computation time" pannel.

![STEPS comptime](https://user-images.githubusercontent.com/89462219/201812314-7c8cfeb4-65a5-4cde-8ad6-947d207cdde0.png)


**Features:**
* The window displays a table with:
    * the trained DNN models,
    * the average computation time of each model,
    * the metric scores on the selected faulty data for a given thresholding method.
* The thresholding method can be changed and the scores will refresh in the table accordingly.
* The table content can be exported as a .csv file
![CompTimeTable](https://user-images.githubusercontent.com/89462219/201811875-0746e932-7fe7-4f85-b360-e0df54e4bfda.png)
* In addition, the user can choose to display certain metric scores according to the computation time of the models in order to better estimate their value during a deployment for real-time detection. The metrics added to the diagram can also be removed one by one.
![ModelsUIAxes](https://user-images.githubusercontent.com/89462219/201813474-c7100401-77f9-47f5-b812-b283a2004354.png)

# Simulink detection
---
<img src="https://user-images.githubusercontent.com/89462219/181750633-b0f31072-e9b5-4590-a040-e0dc5ea5d1d3.png">
In order to perform the detection using the simulink models, the user has to:

1. Select a DNN model from the pretrained models list.
2. Selected a thresholding method.
3. The simulink models can also be opened upon checking the "Open model" checkbox.


The trained model will be automatically saved as a `.mat` file at the following path:
> "\Exported_Models_Sim\DATASET_NAME\MM-DD-YYYY\MODEL_NAME.mat"

and be given into the Simulink model's mask with the lookback window size.

The results are displayed on the platform with the true anomalous data
![SIM_DETECTION](https://user-images.githubusercontent.com/89462219/201815465-2542b9a1-92ec-4e13-8da4-64f121ab7494.png)
