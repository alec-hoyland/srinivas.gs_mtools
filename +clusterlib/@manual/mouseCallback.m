function mouseCallback(self, src, ~)


if self.DrawingClusters
	return
end

R = self.ReducedData;

% show the clicked point
if isempty(self.DisplayFcn)

	% using simple plot


	if gca == self.handles.ax(1)
        pp = get(self.handles.ax(1),'CurrentPoint');
        p(1) = (pp(1,1)); p(2) = pp(1,2);


        x = R(:,1); y = R(:,2);
        [~,cp] = min((x-p(1)).^2+(y-p(2)).^2); % cp C the index of the chosen point
        if length(cp) > 1
            cp = min(cp);
        end

        self.handles.CurrentPointReduced.XData = self.ReducedData(cp,1);
        self.handles.CurrentPointReduced.YData = self.ReducedData(cp,2);
        

        self.handles.CurrentPointRaw.XData = 1:length(self.RawData(:,cp));
        self.handles.CurrentPointRaw.YData = self.RawData(:,cp);

   	end


else
	keyboard
end