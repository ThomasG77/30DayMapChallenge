from ridge_map import RidgeMap

rm = RidgeMap((-1.7149,47.1535,-1.3956,47.2736))
values = rm.get_elevation_data(num_lines=150)
values=rm.preprocess(
    values=values,
    lake_flatness=2,
    water_ntile=5,
    vertical_ratio=60
)
ridges = rm.plot_map(
    values=values,
    label='Nantes et ses environs',
    label_y=0.1,
    label_x=0.51,
    label_size=40,
    linewidth=1
)

ridges.get_figure().set_dpi(300)
ridges.get_figure().savefig('ridge-map-nantes.png')

ridges.get_figure().set_dpi(100)
ridges.get_figure().savefig('ridge-map-nantes-low-res.png')
