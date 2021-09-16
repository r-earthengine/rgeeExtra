context("translate testing - Valeria")

ee_extra <- reticulate::import("ee_extra")
translate <- ee_extra$JavaScript$utils$translate

test_that("image overview - I", {
message <-
"
var loadedImage = ee.Image('JAXA/ALOS/AW3D30/V2_2');
var first = ee.ImageCollection('COPERNICUS/S2_SR')
                .filterBounds(ee.Geometry.Point(-70.48, 43.3631))
                .filterDate('2019-01-01', '2019-12-31')
                .sort('CLOUDY_PIXEL_PERCENTAGE')
                .first();
var uri = 'gs://gcp-public-data-landsat/LC08/01/001/002/' +
    'LC08_L1GT_001002_20160817_20170322_01_T2/' +
    'LC08_L1GT_001002_20160817_20170322_01_T2_B5.TIF';
var cloudImage = ee.Image.loadGeoTIFF(uri);
"
expect_type(translate(message), "character")
})

